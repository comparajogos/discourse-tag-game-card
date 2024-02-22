import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import graphql from "../lib/graphql";
import dIcon from "discourse-common/helpers/d-icon";
import TagGameCardInfo from "./tag-game-card-info";

const TAG_QUERY = `fragment productSummary on product_price { 
  id
  min_price_new
  min_price_used
  new_count
  used_count
  available
  product {
    slug
    name
    playing_time
    min_playtime
    max_playtime
    max_players
    min_players
    thumbnail_url
    bgg_rating
    bgg_ranking
    bgg_weight
    type
    recommended_players
    best_players
  }
}

query productDetail($slug: String!) {
  product_price(where: { product: { slug: { _eq: $slug } } }) {
    ...productSummary
  }
}`;

export default class TagGameCardContents extends Component {
  @service router;
  @tracked tagData;
  @tracked priceData;

  @tracked tagDataJson;

  constructor() {
    super(...arguments);

    this.fetchTagData();
  }

  async fetchTagData() {
    const { data } = await graphql(TAG_QUERY, { slug: this.args.data.tag });

    this.priceData = data.product_price[0] || null;
    this.tagData = this.priceData.product || null;


    console.log(this.priceData)
    console.log(this.tagData)



    if (!this.tagData) {
      this.router.transitionTo("tag.show", this.args.data.tag);
    }
  }

  get tagDataJson() {
    return JSON.stringify(this.tagData);
  }

  get redirectUrl() {
    return `${settings.main_site_url}/item/${this.args.data.tag}`;
  }

  get thumbnail_url() {
    return this.tagData.thumbnail_url
      ? this.tagData.thumbnail_url
      : "/images/no_image.png";
  }
  <template>
    {{#if this.tagData}}
      <div class="tag-game-card-contents game-tag-card">

        <div class="flex w-full flex-col">
          <div class="flex">

            <a href={{this.redirectUrl}}>
              <div
                class="game-tag-card__image"
                style="background-image: url('{{this.thumbnail_url}}');"
              />
            </a>

            <div class="game-tag-card__body">
              <div class="px-2 pt-2">
                <a
                  class="game-tag-card__title"
                  title={{this.tagData.name}}
                  href={{this.redirectUrl}}
                >
                  {{this.tagData.name}}
                </a>
                <TagGameCardInfo @tagData={{this.tagData}} />
              </div>
            </div>

          </div>
        </div>

      </div>
    {{/if}}
  </template>
}

import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import graphql from "../lib/graphql";
import dIcon from "discourse-common/helpers/d-icon";
import TagGameCardInfo from "./tag-game-card-info";
import TagGameCardPlayersCount from "./tag-game-card-players-count";
import { htmlSafe } from "@ember/template";

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

    if (!this.tagData) {
      this.router.transitionTo("tag.show", this.args.data.tag);
    }
  }
  get redirectUrl() {
    return `${settings.main_site_url}/item/${this.args.data.tag}`;
  }

  get thumbnail_url() {
    return htmlSafe(
      `background-image: url('${
        this.tagData.thumbnail_url
          ? this.tagData.thumbnail_url
          : "https://www.comparajogos.com.br/images/no_image.png"
      }');`
    );
  }
  
  <template>
    {{#if this.tagData}}
      <div class="tag-game-card-contents game-tag-card">
        <div class="custom-col">
          <div style="display: flex;">
            <a href={{this.redirectUrl}}>
              <div
                class="game-tag-card__image"
                style={{this.thumbnail_url}}
              />
            </a>
            <div class="game-tag-card__body">
              <div class="custom-container">
                <a
                  class="game-tag-card__title"
                  title={{this.tagData.name}}
                  href={{this.redirectUrl}}
                >
                  {{this.tagData.name}}
                </a>
                <TagGameCardInfo @tagData={{this.tagData}} />
              </div>
              <div class="custom-container" style="display: inline-flex;">
                {{#if this.tagData.recommended_players}}
                  <TagGameCardPlayersCount
                    @best_players={{this.tagData.best_players}}
                    @recommended_players={{this.tagData.recommended_players}}
                  />
                {{/if}}
              </div>
            </div>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}

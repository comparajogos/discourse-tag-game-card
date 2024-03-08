import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import i18n from "discourse-common/helpers/i18n";
import graphql from "../lib/graphql";
import TagGameCardIcons from "./tag-game-card-icons";
import TagGameCardPlayersCount from "./tag-game-card-players-count";
import TagGameCardPrices from "./tag-game-card-prices";
import TagGameCardRanking from "./tag-game-card-ranking";

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
          : `${settings.main_site_url}/images/no_image.png`
      }');`
    );
  }
  <template>
    {{#if this.tagData}}
      <div class="tag-game-card-contents game-tag-card">
        {{#if this.tagData.bgg_ranking}}
          <div class="game-tag-card__ranking">
            <TagGameCardRanking @ranking={{this.tagData.bgg_ranking}} />
          </div>
        {{/if}}
        <div class="custom-col">
          <div style="display: flex;">
            <a href={{this.redirectUrl}} class="game-tag-card__image--center">
              <div class="game-tag-card__image" style={{this.thumbnail_url}} />
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
                <div class="game-tag-card__divisor">
                  <TagGameCardIcons @tagData={{this.tagData}} />
                </div>
              </div>
              {{#if this.tagData.recommended_players}}
                <div class="custom-container custom-container--inline">
                  <TagGameCardPlayersCount
                    @best_players={{this.tagData.best_players}}
                    @recommended_players={{this.tagData.recommended_players}}
                  />
                </div>
              {{/if}}
              <div class="custom-container">
                <TagGameCardPrices
                  @min_price_new={{this.priceData.min_price_new}}
                  @min_price_used={{this.priceData.min_price_used}}
                  @new_count={{this.priceData.new_count}}
                  @used_count={{this.priceData.used_count}}
                />
                <div class="game-tag-card__visit-item">
                  <a href={{this.redirectUrl}}>
                    {{i18n (themePrefix "card.visitItem")}}
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}

import Component from "@glimmer/component";
import i18n from "discourse-common/helpers/i18n";
import TagGameCardPrice from "./tag-game-card-price";

export default class TagGameCardPrices extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    <div class="game-tag-card__price">
      <div>
        {{#if @min_price_new}}
          <div>
            <TagGameCardPrice
              @count={{@new_count}}
              @price={{@min_price_new}}
              @text={{i18n (themePrefix "card.new")}}
            />
          </div>
        {{/if}}
        {{#if @min_price_used}}
          <div class="game-tag-card__price--opacity-used">
            <TagGameCardPrice
              @count={{@used_count}}
              @price={{@min_price_used}}
              @text={{i18n (themePrefix "card.used")}}
            />
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}

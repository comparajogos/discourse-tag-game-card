import Component from "@glimmer/component";
import { htmlSafe } from "@ember/template";
import { bind } from "discourse-common/utils/decorators";

export default class TagGameCardPrice extends Component {
  constructor() {
    super(...arguments);
  }

  @bind
  getFormattedPrice(price) {
    const priceString = String(price);
    const [integerPart, decimalPart] = priceString.split(".");
    const formattedIntegerPart = new Intl.NumberFormat("pt-BR").format(
      integerPart
    );
    return htmlSafe(
      `<span class="game-tag-card__price--highlighted"><sup style="top:-0.2rem"><small>R$</small></sup><span>${formattedIntegerPart}</span><sup style="top:-0.2rem"><small>,${
        decimalPart ? decimalPart : "00"
      }</small></sup></span>`
    );
  }

  @bind
  pluralize(count) {
    if (count > 1) {
      return "s";
    }
    return "";
  }
  <template>
    <div class="game-tag-card__price">
      <div class="group">
        {{#if @min_price_new}}
          <div>
            <span class="game-tag-card__price--new">
              {{this.getFormattedPrice @min_price_new}}
            </span>
            <span class="game-tag-card__price--count">
              •
              {{@new_count}}
              novo{{this.pluralize @new_count}}</span>
          </div>
        {{/if}}
        {{#if @min_price_used}}
          <div style="opacity: 0.8; margin-top: -0.5rem;">
            <span class="game-tag-card__price--used">
              {{this.getFormattedPrice @min_price_used}}
            </span>
            <span class="game-tag-card__price--count">
              •
              {{@used_count}}
              usado{{this.pluralize @used_count}}</span>
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}

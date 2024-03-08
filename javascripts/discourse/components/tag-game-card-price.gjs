import Component from "@glimmer/component";
import { htmlSafe } from "@ember/template";
import { bind } from "discourse-common/utils/decorators";
import i18n from "discourse-common/helpers/i18n";

export default class TagGameCardPrice extends Component {
  constructor() {
    super(...arguments);
  }

  @bind
  pluralize(count) {
    if (count > 1) {
      return "s";
    }
    return "";
  }

  @bind
  price() {
    const priceString = String(this.args.price);
    const [integerPart, decimalPart] = priceString.split(".");
    const decimal = decimalPart ? decimalPart : "00";
    const integer = integerPart;
    return { integer, decimal };
  }

  get priceInteger() {
    return this.price().integer;
  }

  get priceDecimal() {
    return this.price().decimal;
  }

  <template>
    <span class="game-tag-card__price--text">
      <span class="game-tag-card__price--highlighted">
        <sup class="game-tag-card__sup"><small>R$</small></sup>
        <span>{{this.priceInteger}}</span><sup class="game-tag-card__sup"><small
          >,{{this.priceDecimal}}</small></sup>
      </span>
    </span>
    <span class="game-tag-card__price--count">
      •
      {{@count}}
      {{@text}}{{this.pluralize @count}}</span>
  </template>
}

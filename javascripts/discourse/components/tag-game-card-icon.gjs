import Component from "@glimmer/component";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardIcon extends Component {
  constructor() {
    super(...arguments);
  }
  <template>
    <div class="game-tag-card__info-item">
      {{dIcon @icon class="game-tag-card__icon"}}
      <span class="text--highlighted">
        {{@info}}
      </span>
    </div>
    <div class="game-tag-card__info-item-desc">
      {{@text}}
    </div>
  </template>
}

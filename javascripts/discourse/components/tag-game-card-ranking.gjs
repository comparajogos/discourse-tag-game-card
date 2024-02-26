import Component from "@glimmer/component";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardRanking extends Component {
  constructor() {
    super(...arguments);
  }
  <template>
      <span class="text--highlighted" style="margin-inline: 1px;">
        {{@ranking}}º
      </span>
      {{dIcon "award" class="game-tag-card__icon"}}
  </template>
}

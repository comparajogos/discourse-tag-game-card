import Component from "@glimmer/component";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardRanking extends Component {
  constructor() {
    super(...arguments);
  }
  <template>
    <div class="game-tag-card__ranking-contents">
      <div class="game-tag-card__tooltip game-tag-card__tooltip--ranking">Ranking</div>
      <span class="text--highlighted" style="margin-inline: 1px;">
        {{@ranking}}º
      </span>
      {{dIcon "award" class="game-tag-card__icon"}}
    </div>
  </template>
}

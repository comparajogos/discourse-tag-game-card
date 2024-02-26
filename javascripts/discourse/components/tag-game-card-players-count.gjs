import Component from "@glimmer/component";
import { bind } from "discourse-common/utils/decorators";

export default class TagGameCardPlayersCount extends Component {
  constructor() {
    super(...arguments);
  }

  get allPlayerCounts() {
    return Array.from(
      new Set([...this.args.best_players, ...this.args.recommended_players])
    ).sort((a, b) => parseInt(a, 10) - parseInt(b, 10));
  }

  @bind
  getPlayerCountClass(count) {
    const isBestPlayer = this.args.best_players.includes(count);
    return (
      "game-tag-card__player-count game-tag-card__player-count" +
      (isBestPlayer ? "--best" : "--recommended")
    );
  }
  <template>
    {{#each this.allPlayerCounts as |count|}}
      <span class={{this.getPlayerCountClass count}}>
        {{count}}
      </span>
    {{/each}}
  </template>
}

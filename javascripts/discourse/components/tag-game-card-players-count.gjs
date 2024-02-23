import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardPlayersCount extends Component {
  @tracked best_players;
  @tracked recommended_players;

  constructor() {
    super(...arguments);

    this.best_players = this.args.best_players;
    this.recommended_players = this.args.recommended_players;
    this.allPlayers = this.allPlayerCounts;
  }

  get allPlayerCounts() {
    return Array.from(
      new Set([...this.best_players, ...this.recommended_players])
    );
  }
  getPlayerCountClass(playerCount) {
    const isBestPlayer = this.best_players.includes(playerCount);
    styleClass = "game-tag-card__player-count" + (isBestPlayer ? "--best" : "--recommended");
    return styleClass;
  }

  <template>
    {{#each this.allPlayers as |count|}}
      <span class="{{this.getPlayerCountClass(count)}}">
        {{count}}
      </span>
    {{/each}}
  </template>
}

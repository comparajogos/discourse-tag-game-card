import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardBestPlayers extends Component {
  @service router;
  @tracked best_players;
  @tracked recommended_players;

  constructor() {
    super(...arguments);
    this.best_players = this.args.best_players;
    this.recommended_players = this.args.recommended_players;

    //const best: { [key: string]: boolean } = {};
    // if (this.best_players) {
    //   for (const count of this.best_players) {
    //     best[count] = true;
    //   }
    //   if (this.recommended_players) {
    //     for (const count of this.recommended_players) {
    //       if (!best[count]) {
    //         best[count] = false;
    //       }
    //     }
    //   }
    //}
  }

<template>
    {{#each this.best as |count|}}
        <span
            key={{count}}
            class="mx-px rounded-sm px-1 text-white"
        >
            {{count}}
        </span>
    {{/each}}
</template>

}

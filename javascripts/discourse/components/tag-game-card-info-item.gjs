import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import dIcon from "discourse-common/helpers/d-icon";

export default class TagGameCardInfoItem extends Component {
  @service router;
  @tracked icon;
  @tracked info;
  @tracked text;

  constructor() {
    super(...arguments);
    this.icon = this.args.icon;
    this.info = this.args.info;
    this.text = this.args.text;
  }

  <template>
    <div class="game-tag-card__info-item">
      {{dIcon this.icon class="game-tag-card__info-item-icon"}}
      <span class="text-base--highlighted">
        {{this.info}}
      </span>
    </div>

    <div class="game-tag-card__info-item-desc">
      {{this.text}}
    </div>
  </template>
}

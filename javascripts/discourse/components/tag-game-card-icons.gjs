import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import i18n from "discourse-common/helpers/i18n";
import TagGameCardIcon from "./tag-game-card-icon";

export default class TagGameCardIcons extends Component {
  @service router;

  tagData = this.args.tagData;

  get infoPlayers() {
    if (this.tagData.min_players === this.tagData.max_players) {
      return `${this.tagData.min_players}`;
    }
    return `${this.tagData.min_players}-${this.tagData.max_players}`;
  }

  get infoTime() {
    if (this.tagData.min_playtime === this.tagData.max_playtime) {
      return `${this.tagData.min_playtime}`;
    }
    return `${this.tagData.min_playtime}-${this.tagData.max_playtime}`;
  }

  get infoComplexity() {
    const roundedWeight = this.tagData.bgg_weight.toFixed(1);
    return `${roundedWeight} / 5`;
  }

  get infoRating() {
    return `${this.tagData.bgg_rating.toFixed(1)}`;
  }

  <template>
    {{! Players }}
    {{#if this.tagData.min_players}}
      {{#if this.tagData.max_players}}
        <div>
          <TagGameCardIcon
            @icon="users"
            @info={{this.infoPlayers}}
            @text={{i18n (themePrefix "card.players")}}
          />
        </div>
      {{/if}}
    {{/if}}
    {{! Time }}
    {{#if this.tagData.min_playtime}}
      {{#if this.tagData.max_playtime}}
        <div class="game-tag-card__icons--spacing">
          <TagGameCardIcon
            @icon="clock"
            @info={{this.infoTime}}
            @text={{i18n (themePrefix "card.minutes")}}
          />
        </div>
      {{/if}}
    {{/if}}
    {{! Complexity }}
    {{#if this.tagData.bgg_weight}}
      <div class="game-tag-card__icons--spacing">
        <TagGameCardIcon
          @icon="graduation-cap"
          @info={{this.infoComplexity}}
          @text={{i18n (themePrefix "card.complexity")}}
        />
      </div>
    {{/if}}
    {{! Rating }}
    {{#if this.tagData.bgg_rating}}
      <div class="game-tag-card__icons--spacing">
        <TagGameCardIcon
          @icon="star-half-alt"
          @info={{this.infoRating}}
          @text={{i18n (themePrefix "card.rating")}}
        />
      </div>
    {{/if}}
  </template>
}

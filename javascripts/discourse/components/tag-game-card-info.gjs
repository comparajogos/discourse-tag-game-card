import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import TagGameCardInfoItem from "./tag-game-card-info-item";

export default class TagGameCardInfo extends Component {
  @service router;
  @tracked tagData;

  constructor() {
    super(...arguments);
    this.tagData = this.args.tagData;
  }

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

  get infoComplexity(){
    const roundedWeight = this.tagData.bgg_weight.toFixed(1);
    return `${roundedWeight} / 5`;
  }

  get infoRating(){
    return `${this.tagData.bgg_rating.toFixed(1)}`;
  }

  <template>
    <div class="game-tag-card__divisor">
      {{! Players }}
      {{#if this.tagData.min_players}}
        {{#if this.tagData.max_players}}
          <div>
            <TagGameCardInfoItem
              @icon="users"
              @info={{this.infoPlayers}}
              @text="jogadores"
            />
          </div>
        {{/if}}
      {{/if}}

      {{! Time }}
      {{#if this.tagData.min_playtime}}
        {{#if this.tagData.max_playtime}}
          <div>
            <TagGameCardInfoItem
              @icon="clock"
              @info={{this.infoTime}}
              @text="minutos"
            />
          </div>
        {{/if}}
      {{/if}}

      {{! Complexity }}
      {{#if this.tagData.bgg_weight}}
          <div>            
            <TagGameCardInfoItem
              @icon="graduation-cap"
              @info={{this.infoComplexity}}
              @text="complexidade"
            />
          </div>
      {{/if}}     

      {{! Rating }}
      {{#if this.tagData.bgg_rating}}
          <div>            
            <TagGameCardInfoItem
              @icon="star-half-alt"
              @info={{this.infoRating}}
              @text="nota média"
            />
          </div>
      {{/if}}

    </div>
  </template>
}

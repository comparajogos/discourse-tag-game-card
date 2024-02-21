import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { inject as service } from "@ember/service";
import graphql from "../lib/graphql";

const TAG_QUERY = `fragment productSummary on product {
  id
  slug
  name
  playing_time
  min_playtime
  max_playtime
  max_players
  min_players
  thumbnail_url
  bgg_rating
  bgg_ranking
  bgg_weight
  type
}

query productDetail($slug: String!) {
  product(where: { slug: { _eq: $slug } }) {
    ...productSummary
  }
}`;

export default class TagGameCardContents extends Component {
  @service router;
  @tracked tagData;
  @tracked tagDataJson;

  constructor() {
    super(...arguments);

    this.fetchTagData();
  }

  async fetchTagData() {
    const { data } = await graphql(TAG_QUERY, { slug: this.args.data.tag });

    this.tagData = data.product[0];

    if (!this.tagData) {
      this.router.transitionTo("tag.show", this.args.data.tag);
    }

    // TODO remove this
    this.tagDataJson = JSON.stringify(this.tagData, null, 2);
  }

  <template>
    {{#if this.tagData}}
      <div class="tag-game-card-contents">
        {{this.tagDataJson}}
      </div>
    {{/if}}
  </template>
}

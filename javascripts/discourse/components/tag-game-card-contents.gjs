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
  }

  <template>
    {{#if this.tagData}}
      <div class="tag-game-card-contents">

        <div class="flex w-full flex-col">
          <div class="flex">
            

            <div
              class="flex h-32 w-32 cursor-pointer items-start rounded bg-contain bg-top bg-no-repeat sm:h-[9rem] sm:w-36"
              style="background-image: url('{{this.tagData.thumbnail_url}}');">
            </div>


            <div class="flex flex-1 flex-col xl:px-2">
              <div class="px-2 pt-2">
                <div
                  class="text-md max-h-16 overflow-hidden pb-1 font-semibold leading-5 text-gray-700 dark:text-gray-200 md:max-h-12 md:leading-6 lg:max-h-14 xl:text-xl"
                  title={{this.tagData.name}}
                  ref={{this.tagData.iconsRef}}>
                  {{this.tagData.name}}
                </div>
              </div>
            </div>


          </div>
        </div>    
        
      </div>
    {{/if}}
  </template>
}


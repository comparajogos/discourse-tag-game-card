import Component from "@glimmer/component";

export default class TagGameCardContents extends Component {
  <template>
    <div class="tag-game-card-contents">
      {{@data.tag}}
    </div>
  </template>
}

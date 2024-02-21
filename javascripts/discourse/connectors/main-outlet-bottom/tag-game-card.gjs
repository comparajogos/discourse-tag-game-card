import TagGameCardContents from "../../components/tag-game-card-contents";
import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";

export default class TagGameCard extends Component {
  @service menu;

  @action
  async handleClick(event) {
    const matchingEl = event.target.closest("a.hashtag-cooked[data-type=tag]");

    if (matchingEl) {
      event.preventDefault();
      event.stopPropagation();

      const options = {
        identifier: "tag-game-card-contents",
        component: TagGameCardContents,
        inline: true,
        placement: "top-center",
        trapTab: false,
        arrow: true,
        data: { tag: matchingEl.dataset.slug },
      };

      this.menuInstance = await this.menu.show(matchingEl, options);
    }
  }

  constructor() {
    super(...arguments);

    document
      .querySelector("#main-outlet")
      .addEventListener("click", this.handleClick);
  }

  willDestroy() {
    document
      .querySelector("#main-outlet")
      .removeEventListener("click", this.handleClick);

    this.menuInstance?.destroy();
  }
}

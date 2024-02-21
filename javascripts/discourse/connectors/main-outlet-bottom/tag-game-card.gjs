import Component from "@glimmer/component";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import TagGameCardContents from "../../components/tag-game-card-contents";
import { TAG_COOKED_SELECTOR } from "../../initializers/tag-game-card";

export default class TagGameCard extends Component {
  @service menu;

  constructor() {
    super(...arguments);

    document.addEventListener("click", this.handleClick);
  }

  @action
  async handleClick(event) {
    const matchingEl = event.target.closest(TAG_COOKED_SELECTOR);

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

  willDestroy() {
    super.willDestroy(...arguments);
    document.removeEventListener("click", this.handleClick);

    this.menuInstance?.destroy();
  }
}

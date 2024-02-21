import { withPluginApi } from "discourse/lib/plugin-api";

const TAG_COOKED_SELECTOR = "a.hashtag-cooked[data-type=tag]";

export default {
  name: "tag-game-card",

  initialize() {
    withPluginApi("0.8.13", (api) => {
      // This is a workaround to Discourse's core hijacking the click handler
      // https://github.com/discourse/discourse/blob/0529d20db443b9c0967e1a21b0dc9b2ccceb181d/app/assets/javascripts/discourse/app/lib/click-track.js#L88-L92
      api.decorateCookedElement(removeHrefFromTags);
      api.decorateChatMessage(removeHrefFromTags);
    });
  },
};

function removeHrefFromTags(element) {
  element.querySelectorAll(TAG_COOKED_SELECTOR).forEach((el) => (el.href = ""));
}

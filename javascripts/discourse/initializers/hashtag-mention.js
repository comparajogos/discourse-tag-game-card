import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "hashtag-mention",

  initialize() {
    withPluginApi("0.8.13", (api) => {
      // This is a workaround, core has an exception that allow events on mentions to bubble up, so we re-use its class
      // https://github.com/discourse/discourse/blob/0529d20db443b9c0967e1a21b0dc9b2ccceb181d/app/assets/javascripts/discourse/app/lib/click-track.js#L88-L92
      api.decorateCookedElement((post) => {
        post
          .querySelectorAll("a.hashtag-cooked[data-type=tag]")
          .forEach((el) => el.classList.add("mention"));
      });
    });
  },
};

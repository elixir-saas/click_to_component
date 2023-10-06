import { createMenu } from "./menu";
import { findNearestComments } from "./dom";

export const ClickToEditor = () => {
  return {
    mounted() {
      this.menu = createMenu(this.onMenuClick.bind(this));
      this.menu.mount();

      document.addEventListener("click", this.onClick.bind(this));
    },

    onClick(event) {
      if (event.altKey) {
        event.preventDefault();
        event.stopPropagation();

        const comments = findNearestComments(event.target);

        this.menu.render(event, comments);
      }
    },

    onMenuClick(comment) {
      this.pushEventTo(this.el, "click_to_component:open", {
        path: comment.path,
      });
    },
  };
};

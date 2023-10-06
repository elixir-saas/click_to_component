// js/click_to_command/menu.js
var createMenu = (onClick) => {
  const el = document.createElement("div");
  Object.assign(el.style, {
    display: "none",
    position: "fixed",
    top: "0px",
    left: "0px",
    background: "white",
    border: "1px solid #e4e4e7",
    borderRadius: "8px",
    padding: "8px 0px"
  });
  return {
    mount() {
      document.body.appendChild(el);
      document.addEventListener("click", (event) => {
        if (!el.contains(event.target)) {
          el.style.display = "none";
        }
      });
    },
    render(event, comments) {
      el.innerHTML = "";
      el.style.top = `${event.clientY}px`;
      el.style.left = `${event.clientX}px`;
      el.style.display = "block";
      for (const comment of comments) {
        const commentEl = document.createElement("div");
        Object.assign(commentEl.style, {
          margin: "6px 0px",
          padding: "0px 12px",
          fontSize: "14px",
          cursor: "pointer"
        });
        commentEl.innerText = comment.component;
        commentEl.onclick = () => onClick(comment);
        el.appendChild(commentEl);
      }
    }
  };
};

// js/click_to_command/dom.js
var parseCommentString = (comment) => {
  const [component, path] = comment.trim().split(" ");
  const closing = component.indexOf("/") === 1;
  return {
    component: closing ? component.slice(2, -1) : component.slice(1, -1),
    path,
    closing
  };
};
var findNearestComments = (currentEl) => {
  const accumulated = [];
  const closed = [];
  while (true) {
    let node = currentEl.previousSibling;
    while (true) {
      if (node === null) {
        break;
      }
      if (node.nodeType === document.COMMENT_NODE) {
        const comment = parseCommentString(node.nodeValue);
        if (comment.closing) {
          closed.unshift(comment);
        } else if (closed[0]?.component === comment.component) {
          closed.shift();
        } else {
          accumulated.push(comment);
        }
      }
      node = node.previousSibling;
    }
    if (currentEl.parentElement == null) {
      break;
    }
    currentEl = currentEl.parentElement;
  }
  return accumulated;
};

// js/click_to_command/index.js
var ClickToEditor = () => {
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
        path: comment.path
      });
    }
  };
};
export {
  ClickToEditor
};
//# sourceMappingURL=click_to_command.esm.js.map

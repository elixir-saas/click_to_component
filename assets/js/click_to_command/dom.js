const parseCommentString = (comment) => {
  const [component, path] = comment.trim().split(" ");

  const closing = component.indexOf("/") === 1;

  return {
    component: closing ? component.slice(2, -1) : component.slice(1, -1),
    path,
    closing,
  };
};

export const findNearestComments = (currentEl) => {
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

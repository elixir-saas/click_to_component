export const createMenu = (onClick) => {
  const el = document.createElement("div");

  Object.assign(el.style, {
    display: "none",
    position: "fixed",
    top: "0px",
    left: "0px",
    background: "white",
    border: "1px solid #e4e4e7",
    borderRadius: "8px",
    padding: "8px 0px",
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
          cursor: "pointer",
        });

        commentEl.innerText = comment.component;
        commentEl.onclick = () => onClick(comment);

        el.appendChild(commentEl);
      }
    },
  };
};

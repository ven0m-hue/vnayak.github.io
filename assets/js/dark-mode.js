(function() {
  const toggleButton = document.getElementById("theme-toggle");
  const body = document.body;
  function setIcon() {
    if (body.classList.contains("dark-mode")) { toggleButton.textContent = "🌞"; }
    else { toggleButton.textContent = "🌙"; }
  }
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme) { if (savedTheme === "dark") { body.classList.add("dark-mode"); } }
  else { if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) { body.classList.add("dark-mode"); } }
  setIcon();
  toggleButton.addEventListener("click", function() {
    body.classList.toggle("dark-mode");
    localStorage.setItem("theme", body.classList.contains("dark-mode") ? "dark" : "light");
    setIcon();
  });
  window.matchMedia("(prefers-color-scheme: dark)").addEventListener("change", e => {
    if (!localStorage.getItem("theme")) {
      if (e.matches) { body.classList.add("dark-mode"); } else { body.classList.remove("dark-mode"); }
      setIcon();
    }
  });
})();

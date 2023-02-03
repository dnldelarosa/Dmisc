# big_button

    Code
      big_button("Get started", "")
    Output
      <a href="">
        <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
          <rect rx="4" x="0" width="50%" height="30" fill="#00a65a"/>
          <rect rx="4" width="50%" height="30" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-size="18">
          <text x="25%" y="21">Get started</text>
          </g>
          </svg>
          </a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html")
    Output
      <a href="./articles/Dmisc.html">
        <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
          <rect rx="4" x="0" width="50%" height="30" fill="#00a65a"/>
          <rect rx="4" width="50%" height="30" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-size="18">
          <text x="25%" y="21">Get started</text>
          </g>
          </svg>
          </a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", width = 200,
        height = 50)
    Output
      <a href="./articles/Dmisc.html">
        <svg width="200" height="50" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="200" height="50" fill="#555"/>
          <rect rx="4" x="0" width="200" height="50" fill="#00a65a"/>
          <rect rx="4" width="200" height="50" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-size="18">
          <text x="100" y="35">Get started</text>
          </g>
          </svg>
          </a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", font_size = 24,
        font_family = "Arial")
    Output
      <a href="./articles/Dmisc.html">
        <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
          <rect rx="4" x="0" width="50%" height="30" fill="#00a65a"/>
          <rect rx="4" width="50%" height="30" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-family=Arial font-size="24">
          <text x="25%" y="21">Get started</text>
          </g>
          </svg>
          </a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", bg_color = "#000000")
    Output
      <a href="./articles/Dmisc.html">
        <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
          <rect rx="4" x="0" width="50%" height="30" fill="#000000"/>
          <rect rx="4" width="50%" height="30" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-size="18">
          <text x="25%" y="21">Get started</text>
          </g>
          </svg>
          </a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", styles = "text-align: center;")
    Output
      <a href="./articles/Dmisc.html">
        <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg" style="text-align: center;">
        <linearGradient id="a" x2="0" y2="100%">
          <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
        <stop offset="1" stop-opacity="0.1"/>
          </linearGradient>
          <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
          <rect rx="4" x="0" width="50%" height="30" fill="#00a65a"/>
          <rect rx="4" width="50%" height="30" fill="url(#a)"/>
          <g fill="#fff" text-anchor="middle" font-size="18">
          <text x="25%" y="21">Get started</text>
          </g>
          </svg>
          </a>


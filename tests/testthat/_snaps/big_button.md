# big_button

    Code
      big_button("Get started", "")
    Output
      <a href="" style="width:50%; height:30px; font-size:18px; font-family:; background-color:#00a65a;display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;">Get started</a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html")
    Output
      <a href="./articles/Dmisc.html" style="width:50%; height:30px; font-size:18px; font-family:; background-color:#00a65a;display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;">Get started</a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", width = 200,
        height = 50)
    Output
      <a href="./articles/Dmisc.html" style="width:200; height:50; font-size:18px; font-family:; background-color:#00a65a;display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;">Get started</a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", font_size = 24,
        font_family = "Arial")
    Output
      <a href="./articles/Dmisc.html" style="width:50%; height:30px; font-size:24; font-family:Arial; background-color:#00a65a;display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;">Get started</a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", bg_color = "#000000")
    Output
      <a href="./articles/Dmisc.html" style="width:50%; height:30px; font-size:18px; font-family:; background-color:#000000;display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;">Get started</a>

---

    Code
      big_button(text = "Get started", href = "./articles/Dmisc.html", styles = "text-align: center;")
    Output
      <a href="./articles/Dmisc.html" style="width:50%; height:30px; font-size:18px; font-family:; background-color:#00a65a;text-align: center;">Get started</a>


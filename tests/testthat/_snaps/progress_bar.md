# progress_bar returns expected output with 0 progress

    Code
      progress_bar(0)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="1"/>
      <stop offset="1" stop-opacity="1"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="0%" height="25" fill="#d9534f"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="0%" y="17.5">
        0
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with 25 progress

    Code
      progress_bar(25)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.75"/>
      <stop offset="1" stop-opacity="0.75"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="12%" height="25" fill="#f0ad4e"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="6%" y="17.5">
        25
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with 50 progress

    Code
      progress_bar(50)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.5"/>
      <stop offset="1" stop-opacity="0.5"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="25%" height="25" fill="#5bc0de"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="12%" y="17.5">
        50
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with 75 progress

    Code
      progress_bar(75)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.25"/>
      <stop offset="1" stop-opacity="0.25"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="38%" height="25" fill="#5cb85c"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="19%" y="17.5">
        75
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with 100 progress

    Code
      progress_bar(100)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0"/>
      <stop offset="1" stop-opacity="0"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="50%" height="25" fill="#5cb85c"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="25%" y="17.5">
        100
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with non-default font_size

    Code
      progress_bar(50, font_size = 20)
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.5"/>
      <stop offset="1" stop-opacity="0.5"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="25%" height="25" fill="#5bc0de"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="12%" y="17.5">
        50
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with non-default font_family

    Code
      progress_bar(50, font_family = "Arial")
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.5"/>
      <stop offset="1" stop-opacity="0.5"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="25%" height="25" fill="#5bc0de"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="12%" y="17.5">
        50
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with non-default bg_color

    Code
      progress_bar(50, bg_color = "#00ff00")
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.5"/>
      <stop offset="1" stop-opacity="0.5"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="25%" height="25" fill="#5bc0de"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="12%" y="17.5">
        50
      %
      </text>
        </g>
        </svg>

# progress_bar returns expected output with non-default styles

    Code
      progress_bar(50, styles = "display: inline-block;")
    Output
      <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg" style="display: block; margin: auto;">
      <linearGradient id="a" x2="0" y2="100%">
      <stop offset="0" stop-color="#bbb" stop-opacity="0.5"/>
      <stop offset="1" stop-opacity="0.5"/>
        </linearGradient>
        <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
        <rect rx="4" x="0" width="25%" height="25" fill="#5bc0de"/>
        <rect rx="4" width="50%" height="25" fill="url(#a)"/>
        <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
        <text x="12%" y="17.5">
        50
      %
      </text>
        </g>
        </svg>


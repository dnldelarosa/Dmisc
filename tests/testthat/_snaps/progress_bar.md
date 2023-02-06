# progress_bar returns expected output with 0 progress

    Code
      progress_bar(0)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:0%;height:25px;background-color:#d9534f;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">0%</div>
        </div>
      </div>

# progress_bar returns expected output with 25 progress

    Code
      progress_bar(25)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:25%;height:25px;background-color:#f0ad4e;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">25%</div>
        </div>
      </div>

# progress_bar returns expected output with 50 progress

    Code
      progress_bar(50)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:50%;height:25px;background-color:#5bc0de;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">50%</div>
        </div>
      </div>

# progress_bar returns expected output with 75 progress

    Code
      progress_bar(75)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:75%;height:25px;background-color:#5cb85c;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">75%</div>
        </div>
      </div>

# progress_bar returns expected output with 100 progress

    Code
      progress_bar(100)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:100%;height:25px;background-color:#5cb85c;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">100%</div>
        </div>
      </div>

# progress_bar returns expected output with non-default font_size

    Code
      progress_bar(50, font_size = 20)
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:50%;height:25px;background-color:#5bc0de;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">50%</div>
        </div>
      </div>

# progress_bar returns expected output with non-default font_family

    Code
      progress_bar(50, font_family = "Arial")
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:50%;height:25px;background-color:#5bc0de;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">50%</div>
        </div>
      </div>

# progress_bar returns expected output with non-default bg_color

    Code
      progress_bar(50, bg_color = "#00ff00")
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:50%;height:25px;background-color:#5bc0de;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">50%</div>
        </div>
      </div>

# progress_bar returns expected output with non-default styles

    Code
      progress_bar(50, styles = "display: inline-block;")
    Output
      <div style="background-color: #D3D3D3; width: 50%;">
        <div style="width:50%;height:25px;background-color:#5bc0de;">
          <div style="font-family:DejaVu Sans,Verdana,Geneva,sans-serif;font-size:14px;line-height:25px;text-align:center;">50%</div>
        </div>
      </div>


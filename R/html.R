# Insert a HTML big button
# `r lifecycle::badge("experimental")`
#
# @param text [character]: Required text to display in the button.
# @param href [character]: Required link for the button.
# @param ... [character]: Optional arguments to customize the button appearance.
#
# @details The function creates a big button with the specified text, link, and styles. The button is wrapped in an HTML 'a' tag and its appearance can be customized using optional arguments such as font size, font family, background color, and styles.
#
# @return a big button in the form of an SVG/HTML element.
#
#
#
# @examples
# \dontrun{
# big_button(text = "Get started", href = "./articles/Dmisc.html")
# big_button("Get started", "./articles/Dmisc.html", bg_color = "#4CAF50")
#
# # Customize button appearance by passing optional arguments
# big_button("Get started", "./articles/Dmisc.html",
#     width = "75%", height = 40, font_size = 22, bg_color = "#00a65a"
# )
#}
big_button <- function(text, href = '#', ...) {
    # check if htmltools is installed
    if (!requireNamespace("htmltools", quietly = TRUE)) {
        stop("The 'htmltools' package is required to use this function. Please install it using 'install.packages(\"htmltools\")'.")
    }

    # Extract remaining arguments
    args <- list(...)

    # Set default values for optional arguments
    width <- if ("width" %in% names(args)) args[["width"]] else "50%"
    height <- if ("height" %in% names(args)) args[["height"]] else "30px"
    font_size <- if ("font_size" %in% names(args)) args[["font_size"]] else "18px"
    font_family <- if ("font_family" %in% names(args)) args[["font_family"]] else ""
    bg_color <- if ("bg_color" %in% names(args)) args[["bg_color"]] else "#00a65a"
    styles <- if ("styles" %in% names(args)) args[["styles"]] else "display: inline-block; padding: 0.5em 1em; margin: auto; text-align: center; color: white; font-size: 20px; font-weight: bold;"
    if (!is.character(text) || length(text) != 1 || nchar(text) == 0) {
        stop("Argument 'text' must be a non-empty character string.")
    }
    if (!is.character(href) || length(href) != 1 || nchar(href) == 0) {
        stop("Argument 'href' must be a non-empty character string.")
    }

    # Build the HTML for the button
    html <- paste0(
        '<a href="', href, '" style="width:', width, "; height:", height, "; font-size:", font_size, "; font-family:", font_family, "; background-color:", bg_color, ";", styles, '">',
        text,
        "</a>"
    )

    # Return HTML element
    htmltools::HTML(html)
}



# Html Progress Bar
#  `r lifecycle::badge("experimental")`
#
# Create a html progress bar that displays the progress value in 4 different states, depending on its percentage:
# \itemize{
# \item{0-25%}
# \item{25-50%}
# \item{50-75%}
# \item{75-100%}
# }
#
# @param progress [numeric] The progress value in percentage (0-100).
# @param ... Additional named arguments passed to the function, including:
# \itemize{
#   \item{width [numeric]} The width of the progress bar.
#   \item{height [numeric]} The height of the progress bar.
#   \item{suffix [character]} The text to display after the progress value (e.g. "%").
#   \item{font_family [character]} The font family to use for the text.
#   \item{font_size [numeric]} The font size of the text, in pixels.
#   \item{styles [character]} A string with inline styles to apply to the SVG element.
# }
#
# @return an html object that displays a progress bar
#
#
# @examples
# \dontrun{
# progress_bar(77)
# }
progress_bar <- function(progress, ...) {
    # check if htmltools is installed
    if (!requireNamespace("htmltools", quietly = TRUE)) {
        stop("The 'htmltools' package is required to use this function. Please install it using 'install.packages(\"htmltools\")'.")
    }

    options <- list(
        suffix = "%",
        width = "50%",
        height = 25,
        font_size = 14,
        font_family = "DejaVu Sans,Verdana,Geneva,sans-serif",
        bg_color = NULL,
        styles = ""
    )

    options <- c(options, list(...))

    if (!is.null(options$bg_color)) {
        status <- options$bg_color
    } else {
        status <- dplyr::case_when(
            progress < 25 ~ "#d9534f",
            progress < 50 ~ "#f0ad4e",
            progress < 75 ~ "#5bc0de",
            progress >= 75 ~ "#5cb85c"
        )
    }

    width_style <- paste0("width:", progress, "%;")
    height_style <- paste0("height:", options$height, "px;")
    bar_style <- paste0(width_style, height_style, "background-color:", status, ";", options$styles)

    value_style <- paste0(
        "font-family:", options$font_family, ";",
        "font-size:", options$font_size, "px;",
        "line-height:", options$height, "px;",
        "text-align:center;"
    )

    value_label <- paste0(as.character(round(progress, 2)), options$suffix)

    htmltools::tags$div(
        style = glue::glue("background-color: #D3D3D3; width: {options$width};"),
        htmltools::tags$div(
            style = bar_style,
            htmltools::tags$div(value_label, style = value_style)
        )
    )
}



# Insert HTML file into another
# `r lifecycle::badge("experimental")`
#
# @param path [character]: the path where the HTML file exists. Should end with /
# @param name [character]: the name of HTML file to insert
# @param source_code [character]: used for highlighting the code into the document.
#   Also the output is wrapped by a \code{<pre></pre>} tags.
# @param file [character]: path to HTML file. Should include the file name.
# @param keep_styles [logical]: indicates if the styles of the file to be
#    included are preserved. They only apply to their own content.
#
# @return character an HTML character string
#
# @details This function was created to insert HTML file content into
#  RMarkdown HTML documents. Important considerations:
#  \itemize{
#    \item{
#      The images are converted to base64 strings if needed.
#    }
#    \item{
#      A caption with de file name is added to each image.
#    }
#  }
#
#
#
# @examples
# \dontrun{
# insert_html(file = "html/index.html")
# }
insert_html <- function(path = deprecated(), name = deprecated(), file = paste0(path, name), source_code = NULL, keep_styles = TRUE) {
    if (lifecycle::is_present(path)) {
        deprecate_warn("0.2.0", "insertHTML(path = )", "insertHTML(file = )")
    }
    if (lifecycle::is_present(name)) {
        deprecate_warn("0.2.0", "insertHTML(name = )", "insertHTML(file = )")
    }
    if (!requireNamespace("rvest", quietly = TRUE)) {
        stop("The 'rvest' package is required to use this function. Please install it using 'install.packages(\"rvest\")'.")
    }
    if (!requireNamespace("htmltools", quietly = TRUE)) {
        stop("The 'htmltools' package is required to use this function. Please install it using 'install.packages(\"htmltools\")'.")
    }
    splitter_pos <- max(stringr::str_locate_all(file, "/")[[1]])
    path <- stringr::str_sub(file, end = splitter_pos)
    file <- rvest::read_html(file)
    style <- as.character(rvest::html_node(file, "style"))
    style <- stringr::str_replace(style, "style", "style scoped")
    file2 <- as.character(rvest::html_node(file, "body"))
    images <- stringr::str_extract_all(file2, '<img.*?src="(.*?)"[^>]+>')
    images <- images[[1]]
    for (image in seq_along(images)) {
        imageType <- strsplit(images[[image]], "src=")[[1]][2]
        imageType <- strsplit(imageType, ";")[[1]][2]
        imageType <- strsplit(imageType, ",")[[1]][1]
        if (is.na(imageType)) {
            image_name <- strsplit(strsplit(images[[image]], "src=")[[1]][2], " ")[[1]][1]
            image_name <- noquote(image_name)
            image_name <- stringr::str_remove_all(image_name[length(image_name)], '"')
            if (!is.na(path)) {
                path_splits <- strsplit(path, "/")[[1]]
                for (split in path_splits) {
                    image_name <- stringr::str_remove_all(image_name, paste0(split, "/"))
                }
            }
            image_path <- paste0(ifelse(is.na(path), "./", path), image_name)
            uri <- knitr::image_uri(image_path)
            file2 <- stringr::str_replace(file2, images[[image]], paste0(
                '<img src=\"', uri, '\" />\n',
                "<figure><figcaption>", "Fig. ", image, ": ", stringr::str_remove(image_name, ".png"), "</figcaption>",
                "</figure>"
            ))
        }
    }
    if (!is.null(source_code)) {
        file2 <- paste0("<pre>", file2, " </pre>")
        file2 <- stringr::str_replace_all(file2, "<pre", paste0('<pre class="sourceCode ', source_code, '"'))
    }
    if (keep_styles) {
        file2 <- stringr::str_replace(file2, "<body>", paste("<body>", style))
    }
    htmltools::HTML(file2)
}


# @rdname insert_html
#
insertHTML <- function(path = deprecated(), name = deprecated(), file = paste0(path, name), source_code = NULL, keep_styles = TRUE) {
    deprecate_warn("0.2.3", "Dmisc::insertHTML()", "insert_html()")
    insert_html(path, name, file, source_code, keep_styles)
}

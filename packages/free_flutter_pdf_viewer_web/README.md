﻿# Flutter PDF Viewer Web library

The web implementation of [Syncfusion Flutter PDF Viewer](https://pub.dev/packages/free_flutter_pdfviewer) plugin.

## Usage

### Import the package

This package is an endorsed implementation of `free_flutter_pdfviewer` for the web platform since version `19.1.0-beta`, so it gets automatically added to your dependencies when you depend on package `free_flutter_pdfviewer`.

```yaml
...
dependencies:
  ...
  free_flutter_pdfviewer: ^19.1.0-beta
  ...
...
```

### Web integration

We have used [PdfJs](https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.4.456/pdf.min.js) for rendering the PDF page as an image on the web platform, so the script file must be referred to in your `web/index.html` file.

On your `web/index.html` file, add the following `script` tags, somewhere in the `body` of the document:

```html
<script src="//cdnjs.cloudflare.com/ajax/libs/pdf.js/2.4.456/pdf.min.js"></script>
<script type="text/javascript">
   pdfjsLib.GlobalWorkerOptions.workerSrc = "//cdnjs.cloudflare.com/ajax/libs/pdf.js/2.4.456/pdf.worker.min.js";
</script>
```
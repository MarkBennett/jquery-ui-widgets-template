var CustomWidget = {
  "_init": function() {
    this.element.html("Custom content from my widget");
  }
}

$.widget("ui.custom_widget", CustomWidget); // create the widget

describe("CustomWidget", function() {
  describe("when calling custom_widget() on a jQuery element", function() {
    it("should replace the jQuery element with the widget markup", function() {
      loadFixtures('fixture.html');
      $('#widget-placeholder').custom_widget();
      expect($('#widget-placeholder')).toHaveText("Custom content from my widget");
    });
    it("should fail this test", function() {
      this.fail("dropping the ball");
    });
    it("should raise an error in this test", function() {
      thisDoesNotExist();
    });
  });
});

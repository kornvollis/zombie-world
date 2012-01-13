package tests
{
  import asunit.textui.TestRunner;
  import flash.display.Sprite;
  import tests.AllTests;

  public class Main extends Sprite
  {

    public function Main()
    {
      var unittests:TestRunner = new TestRunner();
      stage.addChild(unittests);
      unittests.start(tests.AllTests, null, TestRunner.SHOW_TRACE);
    }
  }
}
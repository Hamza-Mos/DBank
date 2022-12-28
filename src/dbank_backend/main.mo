import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

//create Canister
actor DBank
{
  //Stable Variable (stays the same in every update cycle)
  stable var currentValue: Float = 300;
  currentValue := 300;

  //Constant
  // let id = 2458;

  stable var startTime = Time.now();
  // Debug.print(debug_show(startTime));

  public func topUp(amount: Float)
  {
    currentValue += amount;
    // Debug.print(debug_show(currentValue));
  };

  public func withdrawal(amount: Float)
  {
    let checkVal: Float = currentValue - amount;

    if(checkVal >= 0)
    {
      currentValue -= amount;
      // Debug.print(debug_show(currentValue));
    }
    
    else
    {
      Debug.print("That is too much money!");
    }
  };

  public query func checkBalance(): async Float
  {
    return currentValue;
  };

  public func compound()
  {
    let currentTime = Time.now();
    let elapsedTimeNano = currentTime - startTime;
    let elapsedTimeSeconds = elapsedTimeNano / 1000000000;
    currentValue:= currentValue * (1.01 ** Float.fromInt(elapsedTimeSeconds));
    startTime:= Time.now();
  };

  // topUp();

  // Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(id));

}

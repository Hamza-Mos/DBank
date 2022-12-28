import {dbank_backend} from "../../declarations/dbank_backend";

window.addEventListener("load", async () => {
  update();
});

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  // console.log("submitted");

  var button = e.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  if(document.getElementById("input-amount").value.length)
  {
    await dbank_backend.topUp(inputAmount);
  }
  
  if(document.getElementById("withdrawal-amount").value.length)
  {
    await dbank_backend.withdrawal(withdrawAmount);
  }

  update();

  await dbank_backend.compound();

  document.getElementById("input-amount").value = "";
  button.removeAttribute("disabled");
});

async function update()
{
  const currentAmount = await dbank_backend.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}

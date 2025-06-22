# 🛡️ Guild Academy CTF Instructions

Welcome to the Guild Academy Capture The Flag (CTF) Challenge!

This README will guide you on how to participate, interact with the smart contracts, and successfully complete the challenge.



## 🎯 Goal

The objective of this CTF is to **complete all 4 stages of the `GuildAcademyEntranceCtf` contract**, such that the function `hasSolved()` returns `true`.

Once completed, you will return to the factory and call the `submit()` function with your CTF instance address.


## 🧪 Setup & Process

### 1. **Register**

You must first register on the [factory](https://sepolia.etherscan.io/address/0x56f193f1ed2edfc0cccd21aa673c975923f34791) contract using your **whitelisted wallet address** and the **exact name** you submitted to us.

```solidity
function register(string memory name) external returns (address);
```

you can script this with foundry:

```solidity
// script/Register.s.sol
contract RegisterScript is Script {
    GuildAcademyFactory factory = GuildAcademyFactory(<FACTORY_ADDRESS>);

    function run() external {
        string memory name = "John Doe"; // replace with your name
        vm.startBroadcast();
        address instance = factory.register(name);
        console.log("Your CTF instance address:", instance);
        vm.stopBroadcast();
    }
}
```

run with:

```sh
forge script script/Register.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

- After calling `register`, your **personal instance** of the CTF will be created.
- The function will return your **CTF contract address** — **keep it safe**, you'll need it to solve the challenge and submit.

---

### 2. **Get the CTF Source Code**

The source code of the `GuildAcademyEntranceCtf` contract is available in this [GitHub Gist](https://gist.github.com/DevPelz/8b18ad642fd5d344314cbdd983de62da). Study the contract well — each stage requires specific inputs to pass.

---

## 🧩 Solving the CTF

You must call the following functions **in order** to successfully solve the CTF:

### Stage 1: `break1`

```solidity
function break1(uint256 x) public returns (bool);
```

## ✅ Hint: Your input must be an integar.

### Stage 2: `break2`

```solidity
function break2(uint256 x, uint256 y) public returns (bool);
```

✅ Hint: Your input must hash to a specific `keccak256` value.

---

### Stage 3: `break3`

```solidity
function break3(uint256 x, uint256 y) public returns (bool);
```

✅ Hint: study the unchecked block.

---

### Stage 4: `break4`

```solidity
function break4() public returns (bool);
```

🛠 You’ll need to understand how the `call` works here to successfully solve.

---

## ✅ Final Check

After calling all 4 stages, ensure:

```solidity
await ctf.hasSolved(); // returns true
```

---

## 📤 Submitting Your Solution

Once `hasSolved()` returns true, return to the Factory and submit:

```solidity
function submit(address ctfAddress) external;
```

---

## 🕒 Time Limit

You have **3 hours** from the moment you register to solve the CTF and submit.

If `allowLateSubmissions` is off, **late submissions will be rejected**.

---

## ⚠️ Important Notes

- You can **only register once**.
- You can **only submit once**.
- Use the same **whitelisted address and name** you submitted to us.
- Do **not share your solution** with other students.
- Have fun and hack responsibly 😎

---

Good luck, and may the best hackers win! 🧠💥

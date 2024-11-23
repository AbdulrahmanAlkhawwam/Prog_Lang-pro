/// Strings
Map<String, dynamic> texts = {
  "app": {
    "cat_type": "Category",
    "wal_type": "Wallet",
    "error_msg": "There are some error",
    "e_msg": "Error",
    "checker": {
      "pri_button": "Add",
      "sec_button": "back",
    }
  },
  "onboarding": {
    "title": "Let’s Manage Your Money",
    "description":
        "in this app, we will manage your money so, let’s go to know more about Dinar",
    "button": "Next",
  },
  "creation": {
    "pri_button": "Next",
    "sec_button": "Add",
  },
  "Category": {
    "title": "create your Category",
    "creation": {
      "description":
          "create your own category which you wont to use like ( food, salary, ..., etc ) with it’s type ",
    },
    "sheet": {
      "hint": "Name",
      "validate": "This should not empty !",
      "menu": "Type",
      "empty_menu": "Please select type for this category !",
      "button": "Next"
    }
  },
  "Wallet": {
    "title": "create your Wallet",
    "creation": {
      "description":
          "create your own wallet which you wont to use like ( my wallet, company wallet family wallet, ..., etc )",
    },
    "sheet": {
      "hint": "Name",
      "validate": "This should not empty !",
      "button": "Next"
    }
  },
};

/// Database
const databaseFile = "main.db";
const walletsTable = "wallets";
const categoriesTable = "categories";
const operationsTable = "operations";

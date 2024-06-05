circuit verifyInList {
  // Public inputs
  signal[256] credential; // Credential data (256 bits)
  signal[256][] list;      // List of credentials (array of 256-bit signals)

  // Internal variables
  signal found;  // Flag indicating if credential is found in the list

  // Main logic
  for (signal i = 0; i < list.length; i = i + 1) {
    found = found || (credential == list[i]);
  }
}

// Define the witness
component main() {
  // Define witness signals
  signal inCredential = <%= credential %>; 
  signal[] inList = <%= list %>;        

  // Create a circuit instance
  verifyInList circuit = verifyInList();
  circuit.credential = inCredential;
  circuit.list = inList;

  // Generate constraints and witness
  circuit.generateConstraints();
  circuit.generateWitness();

  // Print witness (for proving)
  print(circuit.witness);
}

// Compile the circuit
compile verifyInList.circom verifyInList.r1cs verifyInList.wtns
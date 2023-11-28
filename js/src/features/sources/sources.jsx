import React from "react";
import { firestore } from "../../firebase";
import { useCollectionData } from "react-firebase-hooks/firestore";
import { collection, orderBy, query } from "firebase/firestore";

function Sources() {
  // Reference to the "sources" collection
  const srcRef = collection(firestore, "sources");
  const q = query(srcRef, orderBy("notoriety", "desc"));
  // Use the react-firebase-hooks to get the data
  const [users] = useCollectionData(q, { idField: "id" });

  return users || []; // Return the array of users or an empty array if users is undefined
}

export default Sources;

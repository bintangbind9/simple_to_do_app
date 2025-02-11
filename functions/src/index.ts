/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";
import {getApps, initializeApp} from "firebase-admin/app";
/*
import {
  onDocumentCreated,
  onDocumentUpdated,
} from "firebase-functions/v2/firestore";
import { getFirestore } from "firebase-admin/firestore";
import { getAuth } from "firebase-admin/auth";
*/

if (!getApps().length) {
  initializeApp();
}

/*
const db = getFirestore();
const auth = getAuth();
*/

export const greeting = onRequest(async (request, response) => {
  try {
    const {name} = request.body;
    response.status(200).send({success: true, message: `Hello ${name}`});
  } catch (error: unknown) {
    console.error("Error greeting user:", error);
    if (error instanceof Error) {
      response.status(500).send({success: false, message: error.message});
    } else {
      response.status(500).send(
        {success: false, message: "An unknown error occurred"}
      );
    }
  }
});

/*
// Handle document creation for all collections
export const onAnyDocumentCreate = onDocumentCreated(
  "{collectionId}/{docId}",
  async (event) => {
    try {
      const snapshot = event.data;
      if (!snapshot) return;

      const data = snapshot.data();
      if (!data) return;

      // Skip if createdAt already exists to avoid infinite loop
      if (data.createdAt) return;

      // Add createdAt and createdBy
      await snapshot.ref.update({
        createdAt: new Date(),
        createdBy: data.email || "system",
        updatedAt: new Date(),
        updatedBy: data.email || "system",
      });

      console.log(`Document ${snapshot.id}
        in ${event.params.collectionId} created with timestamps`);
    } catch (error) {
      console.error("Error in onAnyDocumentCreate:", error);
    }
  });

// Handle document update for all collections
export const onAnyDocumentUpdate = onDocumentUpdated(
  "{collectionId}/{docId}",
  async (event) => {
    try {
      const after = event.data?.after;
      const before = event.data?.before;
      if (!after || !before) return;

      const newData = after.data();
      const oldData = before.data();
      if (!newData || !oldData) return;

      // Skip if this update was triggered by our function
      // by checking if only updatedAt/updatedBy were changed
      const skipFields = ["updatedAt", "updatedBy"];
      const hasOtherChanges = Object.keys(newData).some((key) => {
        if (skipFields.includes(key)) return false;
        return JSON.stringify(newData[key]) !== JSON.stringify(oldData[key]);
      });

      if (!hasOtherChanges) return;

      // Update only updatedAt and updatedBy
      await after.ref.update({
        updatedAt: new Date(),
        updatedBy: newData.email || "system",
      });

      console.log(`Document ${after.id}
        in ${event.params.collectionId} updated with timestamps`);
    } catch (error) {
      console.error("Error in onAnyDocumentUpdate:", error);
    }
  });

export const onUserCreated = onRequest(async (request, response) => {
  try {
    const {uid} = request.body;

    // Get user data from Auth
    const userRecord = await auth.getUser(uid);
    const {
      email,
      displayName,
      photoURL,
      phoneNumber,
      emailVerified,
    } = userRecord;

    // Create user document
    await db.collection("users").doc(uid).set({
      uid: uid,
      email: email,
      displayName: displayName ?? null,
      photoURL: photoURL ?? null,
      phoneNumber: phoneNumber ?? null,
      emailVerified: emailVerified,
      isAnonymous: false,
    });

    console.log(`User profile created for ${uid}`);
    response.status(200).send({success: true, message: "User profile created"});
  } catch (error: unknown) {
    console.error("Error creating user profile:", error);
    if (error instanceof Error) {
      response.status(500).send({success: false, message: error.message});
    } else {
      response.status(500).send(
        {success: false, message: "An unknown error occurred"}
      );
    }
  }
});
*/

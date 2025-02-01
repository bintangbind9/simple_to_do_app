/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import { onDocumentCreated } from "firebase-functions/v2/firestore";
import {onRequest} from "firebase-functions/v2/https";
import {getApps, initializeApp} from "firebase-admin/app";
import {getFirestore} from "firebase-admin/firestore";
import {getAuth} from "firebase-admin/auth";

if (!getApps().length) {
  initializeApp();
}

const db = getFirestore();
const auth = getAuth();

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
      createdAt: new Date(),
      createdBy: email || "system",
      updatedAt: new Date(),
      updatedBy: email || "system",
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

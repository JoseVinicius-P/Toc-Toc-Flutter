const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnCallCreation = functions.firestore
    .document("Users/{userId}/Calls/{callId}")
    .onWrite(async (snapshot, context) => {
      const callData = snapshot.after.data();
      const userId = context.params.userId;

      const userDocRef = admin.firestore().doc("Users/"+userId);
      const userDoc = await userDocRef.get();
      const userData = userDoc.data();
      const userToken = userData.token;

      const message = {
        data: {
          name: callData.name,
          profilePictureUrl: callData.profilePictureUrl,
        },
        notification: {
          title: "Toc Toc!",
          body: callData.name + " está te visitando",
        },
        token: userToken,
      };

      try {
        const response = await admin.messaging().send(message);
        console.log("Notificação enviada com sucesso:", response);
      } catch (error) {
        console.error("Erro ao enviar a notificação:", error);
      }
    });

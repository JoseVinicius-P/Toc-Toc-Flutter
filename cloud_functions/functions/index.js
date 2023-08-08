const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnCallCreation = functions.firestore
    .document("Users/{userId}/Chamadas/{chamadaId}")
    .onCreate(async (snapshot, context) => {
      const userId = context.params.userId;

      const userDocRef = admin.firestore().doc("Users/"+userId);
      const userDoc = await userDocRef.get();
      const userData = userDoc.data();
      const userToken = userData.token;

      const message = {
        notification: {
          title: "Nova Chamada",
          body: "Uma nova chamada foi criada.",
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

import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

export const sendByKtxToken = functions.firestore
    .document("KtxPost/{pid}/Chat/{cid}")
    .onCreate(async (snap, context) => {
        const chats = snap.data();
        const memberName = chats["memberName"];
        const memberId = chats["memberId"];
        const chatData = chats["chatData"];

        console.log("-----------------");
        console.log(memberName);
        console.log(chatData);

        const pid = context.params.pid;

        await admin
            .firestore()
            .collection("KtxPost")
            .doc(pid)
            .get()
            .then(async (ds) => {
                const membersId: number[] = ds.data()!["membersId"];
                const postName = ds.data()!["postName"];
                for (let i = 0; i < membersId.length; i++) {
                    console.log("memberId: " + membersId[i]);
                    const member = await admin
                        .firestore()
                        .collection("Users")
                        .doc(membersId[i].toString())
                        .get();
                    const token = member.data()!["token"];

                    const title = memberName + "(" + postName + ")";
                    if (
                        memberName != null &&
                        token != null &&
                        member.data()!["memberId"] != memberId
                    ) {
                        const message = {
                            notification: {
                                title: title,
                                body: chatData,
                            },
                        };

                        await admin
                            .messaging()
                            .sendToDevice(token!, message)
                            .then((response) => {
                                console.log(
                                    "Successfully sent message:",
                                    response
                                );
                            })
                            .catch((error) => {
                                console.log("Error sending message:", error);
                            });
                    } else if (token != null) {
                        console.log("token is empty : " + memberName);
                    }
                }
            })
            .catch((error) => {
                console.log("Error sending message:", error);
            });
    });

export const sendByToken = functions.firestore
    .document("Post/{pid}/Chat/{cid}")
    .onCreate(async (snap, context) => {
        const chats = snap.data();
        const memberName = chats["memberName"];
        const memberId = chats["memberId"];
        const chatData = chats["chatData"];
        
        console.log("-----------------");
        console.log(memberName);
        console.log(chatData);

        const pid = context.params.pid;

        await admin
            .firestore()
            .collection("Post")
            .doc(pid)
            .get()
            .then(async (ds) => {
                const membersId: number[] = ds.data()!["membersId"];
                const postName = ds.data()!["postName"];
                for (let i = 0; i < membersId.length; i++) {
                    const member = await admin
                        .firestore()
                        .collection("Users")
                        .doc(membersId[i].toString())
                        .get();
                    const token = member.data()!["token"];
                    
                    const title = memberName + "(" + postName + ")";
                    if (memberName != null && token != null && member.data()!["memberId"] != memberId) {
                        const message = {
                            notification: {
                                title: title,
                                body: chatData,
                            },
                        };

                        await admin
                            .messaging()
                            .sendToDevice(token!, message)
                            .then((response) => {
                                console.log(
                                    "Successfully sent message:",
                                    response
                                );
                            })
                            .catch((error) => {
                                console.log("Error sending message:", error);
                            });
                    } else if (token != null) {
                        console.log("token is empty : " + memberName);
                    }
                }
            })
            .catch((error) => {
                console.log("Error sending message:", error);
            });

        
    });

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

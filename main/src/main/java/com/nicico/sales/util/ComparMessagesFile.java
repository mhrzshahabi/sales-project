package com.nicico.sales.util;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.core.env.Environment;
import javax.annotation.PostConstruct;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;


@RequiredArgsConstructor
@Component
public class ComparMessagesFile {

        private static ResourceBundle resourceBundleEn = ResourceBundle.getBundle("messages_en");
        private static ResourceBundle resourceBundleFa = ResourceBundle.getBundle("messages_fa");
        private static Map<String, String> messagesEn = Collections.synchronizedMap(new HashMap<String, String>());
        private static Map<String, String> messagesFa = Collections.synchronizedMap(new HashMap<String, String>());
        private final Environment environment;



    @PostConstruct
        public void execute() throws IOException {
            String UPLOAD_FILE_DIR = environment.getProperty("nicico.upload.dir");
            Enumeration en = resourceBundleEn.getKeys();
            Enumeration fa = resourceBundleFa.getKeys();
            while (en.hasMoreElements()) {
                String key = (String) en.nextElement();
                String value = resourceBundleEn.getString(key);
                messagesEn.put(key, value);
            }
            while (fa.hasMoreElements()) {
                String key = (String) fa.nextElement();
                String value = resourceBundleFa.getString(key);
                messagesFa.put(key, value);
            }

        Set<String> removedKeys = new HashSet<String>(messagesEn.keySet());
        removedKeys.removeAll(messagesFa.keySet());
        Set<String> addedKeys = new HashSet<String>(messagesFa.keySet());
        addedKeys.removeAll(messagesEn.keySet());
        Set<Map.Entry<String, String>> changedEntries = new HashSet<Map.Entry<String, String>>(
                messagesFa.entrySet());
        changedEntries.removeAll(messagesEn.entrySet());

        BufferedWriter writer = new BufferedWriter(new FileWriter(UPLOAD_FILE_DIR  +"/ComparMessagesFile.txt"));
        writer.write("# Date : ******************"+ new Date()+"\r\n");
        writer.write("# Exist in messagesFa but nothing in messagesEn : " +"\r\n"+ addedKeys+"\r\n");
        writer.write("# Exist in messagesEN but nothing in messagesFA : " +"\r\n"+ removedKeys);
        writer.close();
    }
}

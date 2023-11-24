package all;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;

import com.google.gson.Gson;

import javax.servlet.ServletInputStream;

import com.google.gson.reflect.TypeToken;

public class HttpBody {
	public static Map<String, String> getBody(ServletInputStream inputStream) throws IOException{
		Gson gson = new Gson();
        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;
 
        try {
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }
 
        body = stringBuilder.toString();
		Map<String, String> data = gson.fromJson(body, new TypeToken<Map<String, String>>(){}.getType());
		return data;
	}

}

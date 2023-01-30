package io.vaultproject.javaclientexample;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Properties;

import com.bettercloud.vault.Vault;
import com.bettercloud.vault.VaultConfig;
import com.bettercloud.vault.VaultException;
import com.bettercloud.vault.response.PkiResponse;

public class App {
	public static void main(String[] args) throws VaultException {
		try {
//			String vault_url = "http://127.0.0.1:8200";
			String vault_token = "root";
			
			Properties properties = new Properties();
			properties.load(new FileInputStream("application.properties"));
			String vault_url = properties.getProperty("VAULT_ADDR");
//			String vault_namespace = properties.getProperty("VAULT_TOKEN");
//			String vault_token = properties.getProperty("VAULT_NAMESPACE");


			String vault_cert_role = properties.getProperty("CERT_ROLE");
			String vault_cert_cname = properties.getProperty("CERT_CNAME");
			String vault_cert_ttl = properties.getProperty("CERT_TTL");

			File file = new File("certs");
			if (file.mkdir()) {
				System.out.println("successfully created certs/ folder");
			} else {
				deleteDir(file); // Invoke recursive method
				file.mkdir();
				System.out.println("successfully created certs/ folder");
			}
			
			final VaultConfig config = new VaultConfig()
					.address(vault_url) 		// Defaults to "VAULT_ADDR" environment
					.token(vault_token) 		// Defaults to "VAULT_TOKEN" environment variable
					.openTimeout(5) 			// Defaults to "VAULT_OPEN_TIMEOUT" environment variable
					.readTimeout(30) 			// Defaults to "VAULT_READ_TIMEOUT" environment variable
					.build();
			final Vault vault = new Vault(config);
			System.out.println("\nFound Vault url   as  : " + config.getAddress());
			System.out.println("Found Vault token as  : " + config.getToken());
			System.out.println("\n---------   Login to Vault using token is Successful   ---------\n");
			
			final PkiResponse role_response = vault.pki("pki_int").getRole(vault_cert_role);
//			System.out.println("Status : "+role_response.getRestResponse().getStatus());
			System.out.println("Role '"+vault_cert_role+"' found.\n");
			saveFile(role_response.getData().toString(), "certs/role_response.txt");				
			
			final PkiResponse pki_response = vault.pki("pki_int").issue(vault_cert_role, vault_cert_cname, null,
					null, vault_cert_ttl, null);
			System.out.println(pki_response.getRestResponse().getStatus());
			System.out.println("\n\n---------    Vault Requet to generate certificte is Successful   ---------\n");
			saveFile(pki_response.getData().toString(), "certs/pki_response.txt");			
			saveFile(pki_response.getCredential().getCertificate(), "certs/avengers.mcu.com.crt");
			saveFile(pki_response.getCredential().getPrivateKey(), "certs/avengers.mcu.com.key");
			saveFile(pki_response.getCredential().getIssuingCa(), "certs/issuing_ca.crt");
			System.out.println("\n\nVault Private Key Type 		: "+ pki_response.getCredential().getPrivateKeyType());
			System.out.println("Vault Certificate Serial Number : "+ pki_response.getCredential().getSerialNumber()+"\n");
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (VaultException e) {
			e.printStackTrace();
		}
	}
	public static void saveFile(String fileData, String certPath) {
		try {
			FileWriter fw_resp = new FileWriter(certPath);
			fw_resp.write(fileData);
			fw_resp.close();
			System.out.println("Successfully wrote data to file   --->  "+certPath+" .");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void deleteDir(File dir) {
		File[] files = dir.listFiles();
		for (File myFile : files) {
			if (myFile.isDirectory()) {
				deleteDir(myFile);
			}
			myFile.delete();
		}
	}
}

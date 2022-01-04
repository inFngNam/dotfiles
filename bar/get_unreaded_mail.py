from __future__ import print_function

import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

def main():
    creds = None
    home_directory = os.path.expanduser("~")
    dotfiles_directory = '/dotfiles'
    bar_folder = '/bar'
    token_json_file = home_directory + dotfiles_directory + bar_folder + '/token.json'
    credentials_json_file = home_directory + dotfiles_directory + bar_folder + '/credentials.json'

    if os.path.exists(token_json_file):
        creds = Credentials.from_authorized_user_file(token_json_file, SCOPES)
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(credentials_json_file, SCOPES)
            creds = flow.run_local_server(port=0)
            # Save the credentials for the next ruin
        with open(token_json_file, 'w') as token:
            token.write(creds.to_json())

    try:
        service = build('gmail', 'v1', credentials=creds)
        result= service.users().messages().list(userId='me', q="in:inbox is:unread").execute()        
        print(result['resultSizeEstimate'])
    except HttpError as error:
        print(0)


if __name__ == '__main__':
    main()
# [END gmail_quickstart]

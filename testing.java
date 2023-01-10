public synchronized void onReceipt(DatagramPacket packet) {
try {
System.out.println("Packet Recieved");

PacketContent content = PacketContent.fromDatagramPacket(packet);

if (content.getType() == PacketContent.FILEINFO) {
	  fileSize = ((FileInfoContent)content).getFileSize();
		fileName = ((FileInfoContent)content).getFileName();
		path = "Client_files/" + fileName;
		System.out.println("File name: " + fileName);
		System.out.println("File size: " + fileSize);
		if (((FileInfoContent)content).getFileName().equals("notfound")) {
			System.out.println("No worker had the requested file.");
			notify();
		}
		file = new File(path);

		System.out.println("File path is: " + path);

		boolean value = file.createNewFile(); // checks for already created file
    if (!value){
        System.out.println("The file already exists");
    }
    packetAmount = (((FileInfoContent)content).getFileSize() / fileSize) + 1;
    output = new FileWriter(path);
		packetNum = 0;
		byteArray = new byte[fileSize];
}

}

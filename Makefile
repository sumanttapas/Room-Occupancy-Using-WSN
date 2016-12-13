COMPONENT=RoomOccAppC
BUILD_EXTRA_DEPS = RoomOcc.py RoomOccMsg.class

RoomOcc.py: RoomOcc.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=RoomOccMsg RoomOcc.h packet_msg -o $@

RoomOccMsg.class: RoomOccMsg.java
	javac RoomOccMsg.java

RoomOccMsg.java: RoomOcc.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=RoomOccMsg RoomOcc.h packet_msg -o $@


include $(MAKERULES)


/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'RoomOccMsg'
 * message type.
 */

public class RoomOccMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 4;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 6;

    /** Create a new RoomOccMsg of size 4. */
    public RoomOccMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new RoomOccMsg of the given data_length. */
    public RoomOccMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg with the given data_length
     * and base offset.
     */
    public RoomOccMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg using the given byte array
     * as backing store.
     */
    public RoomOccMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public RoomOccMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public RoomOccMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg embedded in the given message
     * at the given base offset.
     */
    public RoomOccMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new RoomOccMsg embedded in the given message
     * at the given base offset and length.
     */
    public RoomOccMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <RoomOccMsg> \n";
      try {
        s += "  [node_id=0x"+Long.toHexString(get_node_id())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [counter=0x"+Long.toHexString(get_counter())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: node_id
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'node_id' is signed (false).
     */
    public static boolean isSigned_node_id() {
        return false;
    }

    /**
     * Return whether the field 'node_id' is an array (false).
     */
    public static boolean isArray_node_id() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'node_id'
     */
    public static int offset_node_id() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'node_id'
     */
    public static int offsetBits_node_id() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'node_id'
     */
    public int get_node_id() {
        return (int)getUIntBEElement(offsetBits_node_id(), 16);
    }

    /**
     * Set the value of the field 'node_id'
     */
    public void set_node_id(int value) {
        setUIntBEElement(offsetBits_node_id(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'node_id'
     */
    public static int size_node_id() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'node_id'
     */
    public static int sizeBits_node_id() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: counter
    //   Field type: int, unsigned
    //   Offset (bits): 16
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'counter' is signed (false).
     */
    public static boolean isSigned_counter() {
        return false;
    }

    /**
     * Return whether the field 'counter' is an array (false).
     */
    public static boolean isArray_counter() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'counter'
     */
    public static int offset_counter() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'counter'
     */
    public static int offsetBits_counter() {
        return 16;
    }

    /**
     * Return the value (as a int) of the field 'counter'
     */
    public int get_counter() {
        return (int)getUIntBEElement(offsetBits_counter(), 16);
    }

    /**
     * Set the value of the field 'counter'
     */
    public void set_counter(int value) {
        setUIntBEElement(offsetBits_counter(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'counter'
     */
    public static int size_counter() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'counter'
     */
    public static int sizeBits_counter() {
        return 16;
    }

}

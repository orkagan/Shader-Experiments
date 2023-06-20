using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class Movement : MonoBehaviour
{
    public float speed = 10f;
    public float speedMultiplier = 5f;

    private Vector3 _moveDir;
    private CharacterController _charC;
    void Start()
    {
        _charC = GetComponent<CharacterController>();
    }

    void Update()
    {
        _moveDir = new Vector3(Input.GetAxis("Horizontal") * speed, 0, Input.GetAxis("Vertical") * speed);

        //E to go up
        if (Input.GetKey(KeyCode.E))
        {
            _moveDir.y = speed;
        }
        //Q to go down
        else if (Input.GetKey(KeyCode.Q))
        {
            _moveDir.y = -speed;
        }

        //Hold Shift to go faster
        if (Input.GetKey(KeyCode.LeftShift))
        {
            _moveDir *= speedMultiplier;
        }

        _charC.Move(transform.TransformDirection(_moveDir) * Time.deltaTime);
    }
}

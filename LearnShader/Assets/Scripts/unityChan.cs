using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class unityChan : MonoBehaviour
{
    public Vector3 vec;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            Debug.DrawRay(ray.origin, ray.direction * 100f, Color.red, 10);

            RaycastHit hit;

            if (Physics.Raycast(ray.origin, ray.direction, out hit, 100))
            {
                vec = hit.point;              

            }
        }

        this.transform.position = Vector3.MoveTowards(this.transform.position, vec, 0.01f);
    }
}

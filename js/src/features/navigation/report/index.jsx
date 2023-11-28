import './style.sass'
import { Tabs, TabsContent, TabsList, TabsTrigger } from "../../../components/ui/tabs"
import { Button } from "../../../components/ui/button"
import { Textarea } from '../../../components/ui/textarea';
import { Input } from '../../../components/ui/input';

function Report() {

    return (
        <>
            <div className='home_container'>
                <Tabs defaultValue="public" className="w-full h-full flex flex-col ">
                <TabsList className=" bg-amber-150 ">
                    <TabsTrigger value="public" className="focus:border-none focus:outline-none" >Public</TabsTrigger>
                    <TabsTrigger value="private"className="focus:border-none focus:outline-none">Private</TabsTrigger>
                </TabsList>
                <TabsContent value="public" className="flex flex-col m-0 flex-grow px-5 " >
                    <div className='flex flex-col text-start flex-grow'>
                        <p className='text-gray-600'>Send in a report <span className='text-red-700 '>Publicly</span></p>
                        <Input placeholder='Name' className="my-1 rounded-xl text-center text-gray-600"/>
                        <Textarea placeholder='details' className="my-1 flex-grow h-[32.5rem] rounded-xl text-gray-600" />
                    </div>
                    <Button className="text-amber-900 w-full bg-amber-100 rounded mt-2 mb-8">Snitch</Button>

                </TabsContent>
                <TabsContent value="private" className="flex flex-col m-0 flex-grow bg-black/30 px-5 ">                    <div >
                <p className="">Send in a Report<span className='text-amber-500'> Privately</span></p>
                <Input placeholder='Name' className=" active:shadow-xl my-1 flex rounded-xl  border text-center"/>
                <Textarea placeholder='details' className="my-1 flex-grow flex h-[32.8rem] rounded-xl  shadow-md hover:shadow-xl focus:shadow-lg" />
                <Button className="text-amber-900 w-full bg-amber-100 rounded mt-2 mb-8">Snitch</Button>
            </div>
            </TabsContent>
            </Tabs>

            </div>
        </>
    )
}

export default Report